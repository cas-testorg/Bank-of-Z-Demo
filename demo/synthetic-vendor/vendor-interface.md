# Synthetic third-party account-analysis interface

**Demo fixture only.** This integration is fictional and does not represent an existing Bank of Z or SunTec implementation. It is not compiled, deployed, or executed.

## Boundary

The bank-owned program `AAEXTR` writes a monthly activity file through DD `AAOUTDD`. JCL step `VENDOR` invokes `VNDAAENG`, an **unavailable third-party executable**. It consumes the outbound file and produces charges through DD `AAINDD`. Bank-owned `AAFEEPST` reads those charges and counts accepted versus rejected records; it does **not** post charges to Db2 or a general ledger.

The implementation, pricing algorithm, exception handling, and internal dependencies of `VNDAAENG` are **unknown**. No source, executable, rate table, or sample calculation is supplied. Do not infer fee calculation from charge amounts.

## Fixed-width file contracts

| File | Copybook | Length | Fields (in order) |
| --- | --- | ---: | --- |
| Outbound activity | `AAOUT.cpy` | 25 bytes | account ID X(8), YYYYMM X(6), service code X(4), activity count 9(7) |
| Inbound charges | `AAIN.cpy` | 28 bytes | account ID X(8), YYYYMM X(6), service code X(4), charge cents 9(9), status X(1) |

Status `A` means accepted by the bank-side adapter; all other values are counted as rejected. This is an illustrative local validation rule, not a vendor fee rule. The adapters do not verify cross-file account reconciliation or rerun idempotency.

## Investigation questions

1. What information crosses the outbound vendor boundary?
2. What bank-owned component consumes vendor charges?
3. What must be reviewed if the service-code field changes width?
4. Can the vendor's fee calculation be established from these artifacts? **No.**

## Known limitations

- `AAEXTR` writes one hardcoded illustrative record, not a real extract from Bank of Z databases.
- `AAFEEPST` performs simple status counting, not financial posting.
- JCL shows intended control flow, not an executed job.
- CoreStory discovery, ingestion, and MCP results must be validated separately; repository presence alone does not establish that CoreStory discovers the relationships.
