
import fs from 'fs';
const wat = fs.readFileSync("test.wat", "utf8");

const regex = /\((ref\.extern|global\.get)\s+([^\)\s]+)\s*\)/g;
const replaced = wat.replaceAll(regex, "(global.get $2/global)");

console.log("Match count:", [...wat.matchAll(regex)].length);
console.log("Has original:", replaced.includes("(global.get $self.console.warn)"));
console.log("Has suffixed:", replaced.includes("(global.get $self.console.warn/global)"));

console.log("Snippet:", replaced.split("\n").find(l => l.includes("console.warn/global")));
