//Create iam scopes
iam.createScope('evci:event:publish','http://evci.corbel.io', [ 	mediaTypes : [ 	"application/json" ], 	"methods" : [ 	"POST" ], 	"type" : "http_access", 	"uri" : "event/.*" ])
