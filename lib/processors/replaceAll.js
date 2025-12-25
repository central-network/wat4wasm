import helpers from "../helpers.js"

export default function (wat) {
    return wat
        .replaceAll("(self)", "(global.get $self)")
        .replaceAll("(null)", "(ref.null extern)")
        .replaceAll("(this)", "(local.get 0)")
        ;
}