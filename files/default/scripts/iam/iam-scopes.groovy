//Create iam scopes

iam.createScope('iam:user:me','http://iam.corbel.io', [	mediaTypes : [ 	"application/json" ], 	"methods" : [ "GET", "PUT", "DELETE", "POST" ], 	"type" : "http_access", 	"uri" : "user/me((/identity)|(/signout)|(/disconnect))?/?", tokenType: "user"])

iam.createScope('iam:user:create','http://iam.corbel.io', [ 	mediaTypes : [ 	"application/json" ], 	"methods" : [ "POST" ],  	"type" : "http_access", 	"uri" : 'user/?' ] )

iam.createScope('iam:username:availability','http://iam.corbel.io', [	mediaTypes : [ 	"application/json" ], 	"methods" : [ "GET", "HEAD" ], 	"type" : "http_access", 	"uri" : "username/[\\w\\-\\+@.]+"])

iam.createScope('iam:email:availability','http://iam.corbel.io', [	mediaTypes : [ 	"application/json" ], 	"methods" : [ "GET", "HEAD" ], 	"type" : "http_access", 	"uri" : "email/[\\w\\-\\+@.]+"])

iam.createScope('iam:user:profile','http://iam.corbel.io', [	mediaTypes : [ 	"application/json" ], 	"methods" : [ "GET" ], 	"type" : "http_access", 	"uri" : "user/\\w+/profile/?", tokenType: "user"])

iam.createScope('iam:user:resetpassword','http://iam.corbel.io', [	mediaTypes : [ 	"application/json" ], 	"methods" : [ "GET" ], 	"type" : "http_access", 	"uri" : "user/resetPassword"])

iam.createScope('iam:user:device','http://iam.corbel.io', [ 	mediaTypes : [ 	"application/json" ], 	"methods" : [ "GET", "PUT", "DELETE" ],  	"type" : "http_access", 	"uri" : 'user/me/devices(/.*)?' ] )


//Admin

iam.createScope('iam:user:delete','http://iam.corbel.io', [ 	mediaTypes : [ 	"application/json" ], 	"methods" : [ 	"DELETE" ], 	"type" : "http_access", 	"uri" : '(?!user/me$)user/.*' ] )

iam.createScope('iam:user:read','http://iam.corbel.io', [	mediaTypes : [ 	"application/json" ], 	"methods" : [ "GET" ], 	"type" : "http_access", "uri" : '(?!user/me$)(?!user/me/(identity|profile)$)user(/\\w+(/(identity|profile))?)?/?' ])

iam.createScope('iam:user:edit','http://iam.corbel.io', 	[	mediaTypes : [ 	"application/json" ], 	"methods" : [ "PUT" ], 	"type" : "http_access", "uri" : 'user/\\w+' ])

iam.createScope('iam:identity:admin','http://iam.corbel.io',[	mediaTypes : [ 	"application/json" ], 	"methods" : [ "GET", "POST" ], 	"type" : "http_access", "uri" : 'user/\\w+/identity' ])

iam.createScope('iam:user:disconnect:admin','http://iam.corbel.io', [ 	mediaTypes : [ 	"application/json" ], 	"methods" : [ "PUT" ],  	"type" : "http_access", 	"uri" : '(?!user/me/disconnect$)user/\\w+/disconnect' ] )

iam.createScope('iam:user:device:admin','http://iam.corbel.io', [ 	mediaTypes : [ 	"application/json" ], 	"methods" : [ "GET", "PUT", "DELETE" ],  	"type" : "http_access", 	"uri" : 'user/\\w+/devices(/.*)?' ] )


//Root


iam.createScope('iam:domain:root','http://iam.corbel.io', [ 	mediaTypes : [ 	"application/json" ], 	"methods" : [ "POST", "GET", "PUT", "DELETE" ],  	"type" : "http_access", 	"uri" : 'domain(/[\\w\\-:@.]+)?/?' ] )
iam.createScope('iam:client:root','http://iam.corbel.io', [ 	mediaTypes : [ 	"application/json" ], 	"methods" : [ "POST", "GET", "PUT", "DELETE" ],  	"type" : "http_access", 	"uri" : 'domain(/[\\w\\-:@.]+)/client(/[\\w\\-@.]+)?/?' ])
iam.createScope('iam:scope:root', 'http://iam.corbel.io', [ 	mediaTypes : [ 	"application/json" ], 	"methods" : [ "POST", "GET",        "DELETE" ],  	"type" : "http_access", 	"uri" : 'scope(/[\\w\\-:@.]+)?/?' ] )
