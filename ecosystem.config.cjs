// Don't Modify the script name that is what starts your application
module.exports = {
  apps : [
  {
    name : "Application Name",
    script : "./index.js",
    env_production: {
      NODE_ENV: "production"
    },
    exec_mode: "cluster",
    instances : "max"
  }
]
}
