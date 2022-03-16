#!/bin/bash
pip install pre-commit

# First pre-commit run: if no errors, just exit zero
pre-commit run --all-files && exit 0

# If we had errors but no changes to code, just exit non-zero
git diff --exit-code || exit 1

# Commit and push changes made by pre-commit hooks
git config user.name github-actions
git config user.email github-actions@github.com
git add -A
git commit -anm "pre-commit auto fixes" || true
git push || true

# Try pre-commit again, passing through exit code
pre-commit run --all-files
