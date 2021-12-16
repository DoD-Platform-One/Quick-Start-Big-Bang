# Big Bang Quick Start

_This is a mirror of a government repo hosted on [Repo1](https://repo1.dso.mil/) by  [DoD Platform One](http://p1.dso.mil/).  Please direct all code changes, issues and comments to <https://repo1.dso.mil/platform-one/quick-start/big-bang>_

This is a small repo to help quickly test basic concepts of Big Bang on a local development machine.

---

# New Quick Start
The Quick Start has been moved to the [following location](https://repo1.dso.mil/platform-one/big-bang/bigbang/-/tree/master/docs/guides/deployment_scenarios) as part of an effort to centralize documentation.



### Services

| URL                                                          | Username  | Password                                                                                                                                                                                   | Notes                                                               |
| ------------------------------------------------------------ | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------- |
| [alertmanager.bigbang.dev](https://alertmanager.bigbang.dev) | n/a       | n/a                                                                                                                                                                                        | Unauthenticated                                                     |
| [grafana.bigbang.dev](https://grafana.bigbang.dev)           | `admin`   | `prom-operator`                                                                                                                                                                            |                                                                     |
| [kiali.bigbang.dev](https://kiali.bigbang.dev)               | n/a       | `kubectl get secret -n kiali -o=json \| jq -r '.items[] \| select(.metadata.annotations."kubernetes.io/service-account.name"=="kiali-service-account") \| .data.token' \| base64 -d; echo` |                                                                     |
| [kibana.bigbang.dev](https://kibana.bigbang.dev)             | `elastic` | `kubectl get secret -n logging logging-ek-es-elastic-user -o=jsonpath='{.data.elastic}' \| base64 -d; echo`                                                                                |                                                                     |
| [prometheus.bigbang.dev](https://prometheus.bigbang.dev)     | n/a       | n/a                                                                                                                                                                                        | Unauthenticated                                                     |
| [tracing.bigbang.dev](https://tracing.bigbang.dev)           | n/a       | n/a                                                                                                                                                                                        | Unauthenticated                                                     |
| [twistlock.bigbang.dev](https://twistlock.bigbang.dev)       | n/a       | n/a                                                                                                                                                                                        | Twistlock has you create an admin account the first time you log in |

