#!/bin/sh
# Tests for skills/commit/scripts/hunk, each in a throwaway repo.
# Run: sh tests/hunk.test.sh (HUNK=path overrides the script under test)
set -u

HUNK=${HUNK:-"$(cd "$(dirname "$0")/.." && pwd)/skills/commit/scripts/hunk"}
root=$(mktemp -d "${TMPDIR:-/tmp}/hunk-test.XXXXXX")
trap 'rm -rf "$root"' EXIT

# Isolate from the machine's git config; t_hostile_config adds its own.
# HOME rather than GIT_CONFIG_GLOBAL, which git before 2.32 ignores.
unset GIT_CONFIG_GLOBAL
export HOME="$root" XDG_CONFIG_HOME="$root" GIT_CONFIG_NOSYSTEM=1
printf '[user]\n\tname = t\n\temail = t@t\n[init]\n\tdefaultBranch = main\n' > "$HOME/.gitconfig"

hunk() { sh "$HUNK" "$@"; }

fail() { echo "  $*" >&2; exit 1; }

status() { "$@" > /dev/null 2>&1 && echo 0 || echo $?; }

eq() { [ "$1" = "$2" ] || fail "$3: expected [$2], got [$(printf '%s' "$1" | od -c | head -5)]"; }

# Id of the first listed hunk whose body contains a line matching $1.
hid() {
	pat=$1
	shift
	hunk list "$@" | awk -v pat="$pat" '
		/^[0-9a-f][0-9a-f]*(\.[0-9]+)?  / { cur = $1; next }
		cur != "" && !found && index($0, pat) { print cur; found = 1 }'
}

# Body line number, within hunk $1, of the first line containing $2.
lno() {
	id=$1 pat=$2
	shift 2
	hunk list "$@" | awk -v id="$id" -v pat="$pat" '
		/^[0-9a-f][0-9a-f]*(\.[0-9]+)?  / { cur = $1; next }
		cur == id && !found && index($0, pat) { print $1; found = 1 }'
}

commit_all() { git add -A && git commit -qm base; }

# Twenty numbered lines; hunks at lines 2 and 18 are far enough apart to split.
twenty() { i=1; while [ $i -le 20 ]; do echo "line $i"; i=$((i + 1)); done; }
two_hunks() {
	twenty > "$1"
	commit_all
	twenty | sed 's/^line 2$/line 2 changed/; s/^line 18$/line 18 changed/' > "$1"
}

t_stage_one_hunk() {
	two_hunks f
	hunk stage "$(hid 'line 2 changed')" > /dev/null
	git show :f | grep -q '^line 2 changed$' || fail "hunk not staged"
	git show :f | grep -q '^line 18$' || fail "other hunk staged too"
	grep -q '^line 18 changed$' f || fail "worktree changed"
}

t_ids_survive_staging_others() {
	two_hunks f
	before=$(hid 'line 18 changed')
	hunk stage "$(hid 'line 2 changed')" > /dev/null
	eq "$(hid 'line 18 changed')" "$before" "id after staging another hunk"
}

# The hunk reads -c -d +C +D; taking both removals and +C leaves D unstaged.
t_stage_lines() {
	printf 'a\nb\nc\nd\ne\n' > f
	commit_all
	printf 'a\nb\nC\nD\ne\n' > f
	id=$(hid '+C')
	hunk stage "$id:$(lno "$id" '-c')-$(lno "$id" '+C')" > /dev/null
	eq "$(git show :f)" "$(printf 'a\nb\nC\ne')" "index after line stage"
}

# An unselected removal becomes context: taking -c and +C keeps d before C.
t_stage_lines_partial_replace() {
	printf 'a\nb\nc\nd\ne\n' > f
	commit_all
	printf 'a\nb\nC\nD\ne\n' > f
	id=$(hid '+C')
	hunk stage "$id:$(lno "$id" '-c'),$(lno "$id" '+C')" > /dev/null
	eq "$(git show :f)" "$(printf 'a\nb\nd\nC\ne')" "index after partial replace"
}

t_repeated_id_merges_lines() {
	printf 'a\nb\nc\nd\ne\n' > f
	commit_all
	printf 'a\nb\nC\nD\ne\n' > f
	id=$(hid '+C')
	hunk stage "$id:$(lno "$id" '-c')" "$id:$(lno "$id" '-d'),$(lno "$id" '+C')" > /dev/null
	eq "$(git show :f)" "$(printf 'a\nb\nC\ne')" "index after merged selection"
}

t_unstage_hunk() {
	two_hunks f
	git add f
	hunk unstage "$(hid 'line 2 changed' --staged)" > /dev/null
	git show :f | grep -q '^line 2$' || fail "hunk still staged"
	git show :f | grep -q '^line 18 changed$' || fail "other hunk unstaged too"
}

t_unstage_lines() {
	printf 'a\nb\nc\nd\ne\n' > f
	commit_all
	printf 'a\nb\nC\nD\ne\n' > f
	git add f
	id=$(hid '+D' --staged)
	hunk unstage "$id:$(lno "$id" '+D' --staged)" > /dev/null
	eq "$(git show :f)" "$(printf 'a\nb\nC\ne')" "index after line unstage"
}

t_no_newline_at_eof() {
	twenty > f
	printf 'last' >> f
	commit_all
	{ twenty | sed 's/^line 2$/line 2 changed/'; printf 'last changed'; } > f
	hunk stage "$(hid 'last changed')" > /dev/null
	eq "$(git show :f | tail -c 12)" "last changed" "eof hunk"
	git show :f | grep -q '^line 2$' || fail "first hunk staged too"
}

t_append_after_missing_newline() {
	printf 'a\nb' > f
	commit_all
	printf 'a\nb\nc' > f
	hunk stage "$(hid '+c')" > /dev/null
	eq "$(git diff)" "" "worktree matches index"
}

# Taking -b +b but not +c must drop the no-newline marker that trails +c.
t_lines_across_missing_newline() {
	printf 'a\nb' > f
	commit_all
	printf 'a\nb\nc' > f
	id=$(hid '+c')
	hunk stage "$id:$(lno "$id" '-b'),$(lno "$id" '+b')" > /dev/null
	eq "$(git cat-file -s :f)" 4 "index is a, b, newline"
}

t_crlf() {
	twenty | sed 's/$/\r/' > f
	commit_all
	twenty | sed 's/^line 2$/line 2 changed/; s/^line 18$/line 18 changed/; s/$/\r/' > f
	hunk stage "$(hid 'line 18 changed')" > /dev/null
	eq "$(git show :f | sed -n 18p)" "$(printf 'line 18 changed\r')" "crlf line staged"
	eq "$(git show :f | sed -n 2p)" "$(printf 'line 2\r')" "crlf other line untouched"
}

t_stale_id() {
	two_hunks f
	id=$(hid 'line 2 changed')
	sed -i.bak 's/^line 2 changed$/line 2 changed again/' f && rm f.bak
	eq "$(status hunk stage "$id")" 2 "exit for stale id"
	eq "$(git diff --cached)" "" "index after stale id"
}

t_dry_run() {
	two_hunks f
	out=$(hunk stage --dry-run "$(hid 'line 2 changed')")
	printf '%s\n' "$out" | grep -q '^+line 2 changed$' || fail "dry run did not print the patch"
	eq "$(git diff --cached)" "" "index after dry run"
}

t_bad_selections() {
	printf 'a\nb\nc\nd\ne\n' > f
	commit_all
	printf 'a\nb\nC\nd\ne\n' > f
	id=$(hid '+C')
	eq "$(status hunk stage "$id:99")" 1 "exit for out of range"
	eq "$(status hunk stage "$id:1")" 1 "exit for context only"
	eq "$(status hunk stage "$id:x")" 1 "exit for garbage"
	eq "$(status hunk stage "$id:")" 1 "exit for empty selection"
	eq "$(status hunk stage deadbeef)" 2 "exit for unknown id"
	eq "$(status hunk stage)" 1 "exit for no ids"
	eq "$(git diff --cached)" "" "index after bad selections"
}

t_whole_files() {
	printf 'x\n' > gone
	printf 'x\n' > script
	printf 'a\000b\n' > bin
	commit_all
	rm gone
	chmod +x script
	printf 'a\000c\n' > bin
	printf 'new\n' > fresh
	out=$(hunk list)
	for want in 'deleted    gone' 'mode       script' 'binary     bin' 'untracked  fresh'; do
		printf '%s\n' "$out" | grep -q "  $want\$" || fail "missing whole-file row: $want"
	done
	printf '%s\n' "$out" | grep -q '^[0-9a-f]' && fail "whole files got hunk ids"
	return 0
}

t_hostile_config() {
	printf 'x \n\ny\n' > f
	twenty >> f
	commit_all
	{ printf 'x \n\ny\n'; twenty | sed 's/^line 2$/line 2 changed /; s/^line 18$/line 18 changed/'; } > f
	git config diff.external false
	git config color.ui always
	git config diff.noprefix true
	git config diff.mnemonicPrefix true
	git config diff.context 10
	git config diff.interHunkContext 40
	git config diff.suppressBlankEmpty true
	git config diff.submodule log
	git config diff.relative true
	git config apply.whitespace error
	GIT_EXTERNAL_DIFF=false hunk stage "$(hid 'line 2 changed')" > /dev/null
	git show :f | grep -q '^line 2 changed $' || fail "hunk not staged"
	git show :f | grep -q '^line 18$' || fail "other hunk staged too"
}

t_subdirectory() {
	two_hunks f
	mkdir sub
	printf 'b\n' > sub/g
	git add sub/g && git commit -qm sub
	printf 'B\n' > sub/g
	cd sub
	hunk stage "$(hid 'line 2 changed')" > /dev/null
	git show :f | grep -q '^line 2 changed$' || fail "top-level hunk not staged from subdir"
	hunk list . | grep -q '  f  ' && fail "path filter leaked a file outside ."
	hunk list . | grep -q '  sub/g  ' || fail "path filter lost sub/g"
}

t_awkward_paths() {
	for p in 'my file' 'café' 'q"uote'; do twenty > "$p"; done
	commit_all
	for p in 'my file' 'café' 'q"uote'; do
		twenty | sed 's/^line 2$/line 2 changed/; s/^line 18$/line 18 changed/' > "$p"
	done
	for p in 'my file' 'café' 'q"uote'; do
		id=$(hid 'line 2 changed' "$p")
		[ -n "$id" ] || fail "no hunk listed for $p"
		hunk stage "$id" > /dev/null
		git show ":$p" | grep -q '^line 2 changed$' || fail "$p not staged"
		git show ":$p" | grep -q '^line 18$' || fail "$p over-staged"
	done
}

failed=0
total=0
for t in $(awk '/^t_[a-z_]*\(\)/ { sub(/\(.*/, ""); print }' "$0"); do
	total=$((total + 1))
	mkdir "$root/$t"
	(cd "$root/$t" && git init -q && set -e && $t)
	if [ $? -eq 0 ]; then echo "ok   $t"; else echo "FAIL $t"; failed=$((failed + 1)); fi
done
echo "$((total - failed))/$total passed"
[ "$failed" -eq 0 ]
