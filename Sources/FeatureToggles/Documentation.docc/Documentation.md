# ``FeatureToggles``

Ergonomic feature toggles for app developers.

## Overview

Feature toggles are vital for a smoothly operating Continuous Integration (CI) 
workflow. They allow you to merge work-in-progress into your main 
branch without disrupting its stability, facilitating continuous deployment.

The `FeatureToggles` package can be useful in such workflows. 
It lets you gate incomplete or untested features behind toggles. 
These toggles can stay turned off in `RELEASE` builds, 
keeping the main branch deployable. Meanwhile, the same toggles can be turned 
on in other environments, so non-ready features can be continuously
integrated, tested and improved.

## Advantages

Compared to other solutions for managing toggles, `FeatureToggles` 
presents a lot of advantages. 

* **It’s distributed.** Different modules can provide new toggles to their clients. That’s great for modular projects.
* **It’s ergonomic.** Inspired by SwiftUI’s `environment`, it lets you access any toggle with a simple `@FeatureToggle`-annotated property.
* **It’s versatile.** Features can be toggled on or off depending on whether it’s a `DEBUG` or `RELEASE` build, and overridden via a specially-formatted URL.
* **It’s strongly typed.** Leveraging the power of Swift's type system, it reduces errors and enhances code readability and maintainability.
* **It’s lightweight.** Just a few lines of code, zero dependencies.

## Topics

### Essentials

- <doc:CreatingYourFirstFeatureToggle>

