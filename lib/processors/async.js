import helpers from "../helpers.js"

export const BLOCK_NAME = "async";

export default function (wat, WAT4WASM) {

    const maskSet = new helpers.MaskSet(wat);
    const inlineFunctions = new Array();

    while (maskSet.hasBlock(BLOCK_NAME)) {
        const block = maskSet.lastBlockOf(BLOCK_NAME);
        const result = block.blockName.split(".").at(1) || "";

        let chain, step, $exit, $name, $prop, $body,
            steps = new helpers.MaskSet(block);

        steps.mask(chain = steps.parseFirstBlock());
        maskSet.mask(block);

        while (steps.hasAnyBlock) {
            steps.mask(step = steps.parseFirstBlock());

            $prop = step.blockName;
            $exit = steps.hasAnyBlock && "ext" || result;

            if (step.hasBlock("ref.func")) {
                $name = helpers.parseFirstBlock(step).$name;
            } else {
                $body = step.toString();
                $name = `$${$prop}_${block.begin}_${step.begin}`;

                $body = $body.substring(
                    $body.indexOf($prop) + $prop.length,
                    $body.lastIndexOf(")")
                ).trim();

                if ($body.startsWith(step.$name)) {
                    $body = $body.substring(
                        $body.indexOf(step.$name) + step.$name.length
                    ).trim();
                }

                inlineFunctions.push(`(func ${$name}\n${$body}\n)`);
            }

            chain = String(`
            (call $self.Reflect.apply<ext.ext.ext>${$exit}
                (ref.extern $self.Promise.prototype.${$prop}<ext>)
                ${chain.toString()}
                (call $self.Array.of<fun>ext (ref.func ${$name}))
            )`);
        }

        console.log({ inlineFunctions });
        maskSet.update(block, helpers.beautify(chain));
    }


    wat = maskSet.restore();

    if (inlineFunctions.length) {
        wat = helpers.append(wat, inlineFunctions.join("\n\n"));
    }

    return wat;
}