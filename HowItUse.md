# How it use:

1. Create enum to call yours service
2. Sign to protocol **NetworkRoute**

![enum API build example](/Resourse/api.png?raw=true)

3. Create new object **SessionManager<"Your enum name">** with generic type
4. call **startSession()** and complitions.

![service working example](/Resourse/call.png?raw=true)
