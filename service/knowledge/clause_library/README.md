# Clause library

The seed clause index used by `tools.clause_search.ClauseLibrary` is
currently in-memory, in the Python module itself, so the graph can run
without a database at demo time.

A production build moves these into a Chroma / LanceDB collection:

    ./clauses.chroma/           # persistent collection
    ./index.json                # {clause_id, source, revision, hash}
    ./revisions/                # archived revisions (append-only)

Hot-patch discipline (plan §5.1):

1. Add the new revision to `./revisions/` — never overwrite.
2. Update `./index.json` with the new hash and the date in force.
3. Re-run the twin-sample regression (`pytest tests/test_twin_sample.py`).
4. Only after the regression passes, update the ClauseLibrary default to
   point at the new revision.

The hackathon cut ships with the ~10 seed clauses the two reference samples
actually hit. Real coverage is an 80-sprint effort under joint MAA/CAA
configuration control.
