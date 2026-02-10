
(
echo "
log:
  # The level of logging, can be trace, debug, info, warn, error, fatal
  level: trace

runner:
  # Where to store the registration result.
  file: .runner
  capacity: 1
  labels:
    - "myrunner1:host"
    - "myrunner1"

container:
  privileged: false

"
) > __workdir/config.toml
