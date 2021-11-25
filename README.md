Lingua Franca Alarm Clock
----------------------------

A small and tiny alarmclock which is written using the scheduling and time features from lingua franca. 

**Contact:** <revol-xut@protonmail.com>

## Building

**Dependencies:** jdk11, boost, mpg321

```bash
    $ lfc ./src/Networking.lf
```

## Endpoints

### /list **GET**
Returns a list of upcoming events.

```
    "timestamp": {
        "date": str (human readable)
        "message": str
    }
```


### /stop **GET**
Stops the currently playing alarm sound.

```
{
    "success": "exit code" // 0 means successfull
}
```

### /add_event_timestamp **POST**
Will schedule your alarmclock for the given timestamp

Request:
```
{
    "message": str,
    "time_stamp": int
}
```
Response:
```
{
    "success": true
}
```

### /add_event_relative **POST**
Will schedule a event relative to the current time.

Request
```json
{
    "days": int(optional),
    "hours": int(optional),
    "minutes": int(optional),
    "seconds": int(optional)
}
```

Response:
```
{
    "success": true
}
```

### /add_event_time **POST**
Schedule event for this time in the next 24 hours. If a parameter
is unspecified the current time is used.

Request
```json
{
    "hour": int(optional),
    "minute": int(optional),
    "second": int(optional)
}
```

Response:
```json
{
    "success": true
}
```


