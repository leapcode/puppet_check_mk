# adjust.mk - checks we need to adjust the defaults

## global defaults
# memory usage (default 150/200%, float val indicates % of physical RAM)
memused_default_levels = (90.0, 95.0)

## host overrides
# some check types cannot be adjusted via check_parameters, so we explicitly
#  create redundant checks using host lists or tags
checks += [
  ( ['foo.example.org','bar.example.org'], 'cpu.threads', None, (6000, 7000) ),
]
