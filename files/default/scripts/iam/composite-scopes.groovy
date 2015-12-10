iam.createCompositeScope('iam:comp:base',   'iam:user:create', 'iam:user:me', 'iam:username:availability', 'iam:email:availability','iam:user:profile', 'iam:user:resetpassword', 'iam:user:device')
iam.createCompositeScope('iam:comp:admin',  'iam:comp:base', 'iam:user:delete', 'iam:user:read', 'iam:user:edit', 'iam:identity:admin', 'iam:user:disconnect:admin', 'iam:user:device:admin')
iam.createCompositeScope('iam:comp:root',   'iam:comp:admin', 'iam:domain:root', 'iam:client:root', 'iam:scope:root')

iam.createCompositeScope('evci:comp:base',   'evci:event:publish')
iam.createCompositeScope('evci:comp:admin',  'evci:comp:base')

iam.createCompositeScope('silkroad:comp:base', 'iam:comp:base', 'evci:comp:base')
iam.createCompositeScope('silkroad:comp:admin', 'iam:comp:admin', 'evci:comp:admin')
iam.createCompositeScope('silkroad:comp:root', 'silkroad:comp:admin', 'iam:comp:root')
