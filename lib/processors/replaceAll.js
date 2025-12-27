import helpers from "../helpers.js"

export default function (wat) {
    return wat
        .replaceAll("(self)", "(global.get $self)")
        .replaceAll("(null)", "(ref.null extern)")
        .replaceAll("(func)", "(ref.null func)")
        .replaceAll("(this)", "(local.get 0)")
        .replaceAll("(array)", "(call $self.Array<>ext)")
        .replaceAll("(object)", "(call $self.Object<>ext)")
        .replaceAll("(console $", "(call $self.console.")
        .replaceAll("(reflect $", "(call $self.Reflect.")
        .replaceAll("(bigint $", "(call $self.BigInt.")
        .replaceAll("(number $", "(call $self.Number.")
        .replaceAll("(string $", "(call $self.String.")
        .replaceAll("(object $", "(call $self.Object.")
        .replaceAll("(array $", "(call $self.Array.")
        .replaceAll("(self $", "(ref.extern $self.")
        .replaceAll("(url $", "(ref.extern $self.URL.")

        .replaceAll(/\(apply(?:\.*)(i32|f32|i64|f64|fun|ext|)(\s*)/g, `(call $self.Reflect.apply<ext.ext.ext>$1 $2`)
        ;
}