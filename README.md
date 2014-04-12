Test app for detecting multiple mice attached to a single computer.

Uses [ManyMouse](http://icculus.org/manymouse/) for cross-platform goodness!

---

Why would I want to do this? The top reason is to distinguish setups so default controls configurations can be properly applied for a game. For example, a computer may have a keyboard and external mouse, a keyboard and trackpad (e.g., a laptop with no external mouse), a gamepad, or something else.

A common scenario with PC games is to assume a keyboard and mouse, which is a pretty good assumption as a modern computer is essentially unusable by most people without both. The trouble is that the "mouse" might be a touch screen or a trackpad -- something that appears as a mouse to the system but isn't an actual "mouse". These mouse substitutes are typically poor replacements for an actual mouse when it comes to gaming.

By testing for multiple mice (and the presence of a battery in the computer) we can make an informed guess about whether the user is running on a notebook computer and if that user has an external mouse or just a trackpad.