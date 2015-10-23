for var_name in ['PATH', 'HOME', 'HOMEPATH', 'USER', 'USERNAME', 'LANG', 'EDITOR']
  console.log "#{var_name}:", process.env[var_name]

console.log "All vars:\n" + (Object.keys process.env).join(", ")
