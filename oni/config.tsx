
import * as React from "react"
import * as Oni from "oni-api"

export const activate = (oni: Oni.Plugin.Api) => {
    console.log("config activated")

    // Input
    //
    // Add input bindings here:
    //
    oni.input.bind("<c-enter>", () => console.log("Control+Enter was pressed"))

    //
    // Or remove the default bindings here by uncommenting the below line:
    //
    // oni.input.unbind("<c-p>")

}

export const deactivate = (oni: Oni.Plugin.Api) => {
    console.log("config deactivated")
}

export const configuration = {
    //add custom config here, such as

    "achievements.enabled": false,

    "oni.useDefaultConfig": false,
    "oni.loadInitVim": true,
    "oni.useExternalPopupMenu": true,
    "editor.fontSize": "14px",
    "editor.fontFamily": "Consolas",
    "editor.quickOpen.execCommand": 'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always"',

    // UI customizations
    "ui.colorscheme": "one",
    "ui.animations.enabled": true,
    "ui.fontSmoothing": "auto",
    "tabs.mode": "buffers",

    "experimental.indentLines.enabled": true,
    "editor.textMateHighlighting.enabled": true
}
