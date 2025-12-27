import helpers from "../helpers.js"

export const BLOCK_NAME = "new";

export default function (wat) {

    while (helpers.hasBlock(wat, BLOCK_NAME)) {

        const block = helpers.lastBlockOf(wat, BLOCK_NAME);
        const $name = block.$name;
        const param = $name.split(">").at(0).split("<").at(1) || "";

        const $constructor = `(ref.extern $self.${$name.substring(1)}<ext>)`;
        const $arguments = block.replace(`(new ${$name}`, `(array $of<${param}>ext`);
        const $reflect = `(reflect $construct<ext.ext>ext\n${$constructor}\n${$arguments}\n)`;

        wat = block.replacedRaw(helpers.beautify($reflect));
    }

    return wat;
}