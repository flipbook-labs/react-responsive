<h1 align="center">react-responsive</h1>
<h3 align="center">A responsive utility toolkit for React Lua</h3>

## Installation

### Wally

```
ReactResponsive = "flipbook-labs/react-responsive@<version>
```

## Usage

### ScreenProvider

Should be created at the root of your App

```lua
local React = require(React)
local e = React.createElement

local ReactResponsive = require(ReactResponsive)
local ScreenProvider = ReactResponsive.ScreenProvider

local function App()
    local children = {}

    return e(ScreenProvider, {
        --[[
        baseFontSize: number?,
        baseScreenSize: Vector2?,
        breakpoints: { Breakpoint }?,
            How often you want rem, and the current breakpoint
            to update.
        updateInterval: number?,
        ]]
    }, children)
end
```

### useRem

```lua
local React = require(React)
local e = React.createElement

local ReactResponsive = require(ReactResponsive)
local useRem = ReactResponsive.useRem

local function MyComponent()
    local rem = useRem()

    return e("Frame", {
        Size = UDim2.fromOffset(rem(10), rem(10))
    })
end
```

### useMediaQuery

```lua
local React = require(React)
local e = React.createElement

local ReactResponsive = require(ReactResponsive)
local useMediaQuery = ReactResponsive.useMediaQuery

local function MyComponent()
    local showSideNav = useMediaQuery({
        minBreakpoint = "sm",
        maxBreakpoint = "lg"
    })

    return showSideNav and e(SideNav) or e(TopNav)
end
```

### useBreakpointValue

```lua
local React = require(React)
local e = React.createElement

local ReactResponsive = require(ReactResponsive)
local useBreakpointValue = ReactResponsive.useBreakpointValue

local function MyComponent()
    local text = useBreakpointValue({
        lg = "I am a large breakpoint text label",
        xl = "I am an extra large breakpoint text label",
        base = "I am a text label for any breakpoint smaller than large."
    })

    return e("TextLabel", {
        Text = text,
    })
end
```
