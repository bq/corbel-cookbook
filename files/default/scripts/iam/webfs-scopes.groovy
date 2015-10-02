iam.createScope('webfs:object','http://webfs.corbel.io', [ 	mediaTypes : [ 	"*/*" ], 	"methods" : [ "GET" ], "type" : "http_access", 	"uri" : ".*",  tokenType: "user"])
