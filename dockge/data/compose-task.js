const CommonEvn = "common.env";
const AppData = "/app/data";
export const ComposeTask={
  deploy: [ "compose", "--env-file", `${AppData}/${CommonEvn}`, "--env-file", ".env", "up", "-d", "--remove-orphans" ],
  start : [ "compose", "--env-file", `${AppData}/${CommonEvn}`, "--env-file", ".env", "up", "-d", "--remove-orphans" ],
  update: [ "compose", "--env-file", `${AppData}/${CommonEvn}`, "--env-file", ".env", "up", "-d", "--remove-orphans" ],
}
