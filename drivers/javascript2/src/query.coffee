goog.provide("rethinkdb.query")

goog.require("rethinkdb.base")
goog.require("rethinkdb.ast")

rethinkdb.expr = ar (val) ->
    if val instanceof TermBase
        val
    else if val instanceof Function
        new Func {}, val
    else if goog.isArray val
        new MakeArray {}, val...
    else if goog.isObject val
        new MakeObject val
    else
        new DatumTerm val

rethinkdb.js = ar (jssrc) -> new JavaScript {}, jssrc

rethinkdb.error = ar (errstr) -> new UserError {}, errstr

rethinkdb.row = new ImplicitVar {}

rethinkdb.db = ar (dbName) -> new Db {}, dbName

rethinkdb.dbCreate = ar (dbName) -> new DbCreate {}, dbName

rethinkdb.dbDrop = ar (dbName) -> new DbDrop {}, dbName

rethinkdb.dbList = -> new DbList {}

rethinkdb.do = (args...) -> new FunCall {}, funcWrap(args[-1..][0]), args[...-1]...

rethinkdb.branch = ar (test, trueBranch, falseBranch) -> new Branch {}, test, trueBranch, falseBranch

rethinkdb.count =           {'COUNT': true}
rethinkdb.sum   = ar (attr) -> {'SUM': attr}
rethinkdb.avg   = ar (attr) -> {'AVG': attr}