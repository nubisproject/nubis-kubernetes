# Change Log

## [v2.3.0](https://github.com/nubisproject/nubis-kubernetes/tree/v2.3.0) (2018-08-01)
[Full Changelog](https://github.com/nubisproject/nubis-kubernetes/compare/v2.3.0...v2.3.0)

**Closed issues:**

- Tag v2.3.0 release [\#92](https://github.com/nubisproject/nubis-kubernetes/issues/92)

**Merged pull requests:**

- Revert "\[cahoskube\] Skip pods with a certain exlude annotation" [\#97](https://github.com/nubisproject/nubis-kubernetes/pull/97) ([limed](https://github.com/limed))

[Full Changelog](https://github.com/nubisproject/nubis-kubernetes/compare/v2.3.0...v2.3.0)

**Closed issues:**

- Fix nubis-metadata call [\#90](https://github.com/nubisproject/nubis-kubernetes/issues/90)
- Tag v2.3.0 release [\#87](https://github.com/nubisproject/nubis-kubernetes/issues/87)

**Merged pull requests:**

- Fixing kube-sd.sh to call nubis-metadata properly [\#91](https://github.com/nubisproject/nubis-kubernetes/pull/91) ([limed](https://github.com/limed))

[Full Changelog](https://github.com/nubisproject/nubis-kubernetes/compare/v2.3.0...v2.3.0)

**Closed issues:**

- Tag v2.3.0 release [\#84](https://github.com/nubisproject/nubis-kubernetes/issues/84)

[Full Changelog](https://github.com/nubisproject/nubis-kubernetes/compare/v2.3.0...v2.3.0)

**Closed issues:**

- Build fails trying to start td-agent [\#82](https://github.com/nubisproject/nubis-kubernetes/issues/82)
- Tag v2.3.0 release [\#79](https://github.com/nubisproject/nubis-kubernetes/issues/79)

**Merged pull requests:**

- Inhibit td-agent startup during builds [\#83](https://github.com/nubisproject/nubis-kubernetes/pull/83) ([tinnightcap](https://github.com/tinnightcap))

[Full Changelog](https://github.com/nubisproject/nubis-kubernetes/compare/v2.3.0...v2.3.0)

**Closed issues:**

- Tag v2.3.0 release [\#74](https://github.com/nubisproject/nubis-kubernetes/issues/74)

**Merged pull requests:**

- Pass enabled flag for info and bucket modules [\#78](https://github.com/nubisproject/nubis-kubernetes/pull/78) ([tinnightcap](https://github.com/tinnightcap))

[Full Changelog](https://github.com/nubisproject/nubis-kubernetes/compare/v2.3.0...v2.3.0)

**Closed issues:**

- Tag v2.3.0 release [\#71](https://github.com/nubisproject/nubis-kubernetes/issues/71)

**Closed issues:**

- Pick a sane default for max-minions [\#69](https://github.com/nubisproject/nubis-kubernetes/issues/69)
- \[cahoskube\] Skip pods with a specific annotation [\#67](https://github.com/nubisproject/nubis-kubernetes/issues/67)
- \[bug\] Startup script incorreectly detects CentOS [\#65](https://github.com/nubisproject/nubis-kubernetes/issues/65)
- Remove git sha1 from revision [\#63](https://github.com/nubisproject/nubis-kubernetes/issues/63)
- Deploy cahoskube [\#56](https://github.com/nubisproject/nubis-kubernetes/issues/56)
- Deploy kube2iam [\#55](https://github.com/nubisproject/nubis-kubernetes/issues/55)
- Allow terraform to deploy this using our account deployment process [\#51](https://github.com/nubisproject/nubis-kubernetes/issues/51)
- \[Dashboard\] Expose dashboard as a NodePort [\#49](https://github.com/nubisproject/nubis-kubernetes/issues/49)
- Dns resolution upstream is broken [\#46](https://github.com/nubisproject/nubis-kubernetes/issues/46)
- Include dashboard and heapster add-ons [\#42](https://github.com/nubisproject/nubis-kubernetes/issues/42)
- Fix service discovery puppet code [\#41](https://github.com/nubisproject/nubis-kubernetes/issues/41)
- Enable RBAC [\#40](https://github.com/nubisproject/nubis-kubernetes/issues/40)
- Use nubis-terraform/worker/userdata to generate instance additionnal user-data [\#38](https://github.com/nubisproject/nubis-kubernetes/issues/38)
-  Open up ports for monitoring security groups [\#36](https://github.com/nubisproject/nubis-kubernetes/issues/36)
- Consul does not restart [\#28](https://github.com/nubisproject/nubis-kubernetes/issues/28)
- Use image module [\#27](https://github.com/nubisproject/nubis-kubernetes/issues/27)
- Display some handy output [\#25](https://github.com/nubisproject/nubis-kubernetes/issues/25)
- Account Terraform and Kubernetes conflicting [\#24](https://github.com/nubisproject/nubis-kubernetes/issues/24)
- Figure out a way to inject userdata for nubis\_purpose [\#21](https://github.com/nubisproject/nubis-kubernetes/issues/21)
- make ssh key optional [\#17](https://github.com/nubisproject/nubis-kubernetes/issues/17)
- Export kubernetes logs to fluent collectors [\#16](https://github.com/nubisproject/nubis-kubernetes/issues/16)
- Enable cluster rolling updates [\#14](https://github.com/nubisproject/nubis-kubernetes/issues/14)
- Expose node type in consul service [\#13](https://github.com/nubisproject/nubis-kubernetes/issues/13)
- Enable SSH access from Jumphost [\#11](https://github.com/nubisproject/nubis-kubernetes/issues/11)
- Use Kubernetes 1.9.7 [\#7](https://github.com/nubisproject/nubis-kubernetes/issues/7)
- Inject nubis-metadata in additionalUserData [\#6](https://github.com/nubisproject/nubis-kubernetes/issues/6)
- Enable HTTP proxies [\#5](https://github.com/nubisproject/nubis-kubernetes/issues/5)

**Merged pull requests:**

- Set max-minion to 2x what min-minion is set at [\#70](https://github.com/nubisproject/nubis-kubernetes/pull/70) ([gozer](https://github.com/gozer))
- \[chaoskube\] Skip pods with a certain exlude annotation [\#68](https://github.com/nubisproject/nubis-kubernetes/pull/68) ([gozer](https://github.com/gozer))
- Fix CentOS case [\#66](https://github.com/nubisproject/nubis-kubernetes/pull/66) ([gozer](https://github.com/gozer))
- Official projects don't need to use the git sha in their revisions [\#64](https://github.com/nubisproject/nubis-kubernetes/pull/64) ([gozer](https://github.com/gozer))
- Extend our Dashboard add-on to include a read-only dashboard role [\#62](https://github.com/nubisproject/nubis-kubernetes/pull/62) ([gozer](https://github.com/gozer))
- Add some missed count=var.enabled [\#61](https://github.com/nubisproject/nubis-kubernetes/pull/61) ([gozer](https://github.com/gozer))
- Fix incorrect addon path [\#60](https://github.com/nubisproject/nubis-kubernetes/pull/60) ([gozer](https://github.com/gozer))
- chaoskube [\#58](https://github.com/nubisproject/nubis-kubernetes/pull/58) ([gozer](https://github.com/gozer))
- kube2iam [\#57](https://github.com/nubisproject/nubis-kubernetes/pull/57) ([gozer](https://github.com/gozer))
- Use Kops channels to create a NodePort for Kubernetes Dashboard [\#54](https://github.com/nubisproject/nubis-kubernetes/pull/54) ([gozer](https://github.com/gozer))
- Fix DNS on startup [\#53](https://github.com/nubisproject/nubis-kubernetes/pull/53) ([gozer](https://github.com/gozer))
- Initial attempt to get kubernetes deploy into our account deployment [\#52](https://github.com/nubisproject/nubis-kubernetes/pull/52) ([limed](https://github.com/limed))
- Ensure we can use the correct DNS resolver [\#50](https://github.com/nubisproject/nubis-kubernetes/pull/50) ([gozer](https://github.com/gozer))
- Forcing ssh pubkey to be the nubis pubkey [\#48](https://github.com/nubisproject/nubis-kubernetes/pull/48) ([limed](https://github.com/limed))
- Fix upstream DNS resolution [\#47](https://github.com/nubisproject/nubis-kubernetes/pull/47) ([gozer](https://github.com/gozer))
- Enable rbac [\#45](https://github.com/nubisproject/nubis-kubernetes/pull/45) ([limed](https://github.com/limed))
- Fixing puppet code for service discovery [\#44](https://github.com/nubisproject/nubis-kubernetes/pull/44) ([limed](https://github.com/limed))
- Deploy dashboard + heapster by default [\#43](https://github.com/nubisproject/nubis-kubernetes/pull/43) ([gozer](https://github.com/gozer))
- Use nubis-terraform/worker/userdata to generate additional instance metadata [\#39](https://github.com/nubisproject/nubis-kubernetes/pull/39) ([gozer](https://github.com/gozer))
- Open up ports for api endpoints so that we can monitor them [\#37](https://github.com/nubisproject/nubis-kubernetes/pull/37) ([limed](https://github.com/limed))
- Fixing consul restart issues [\#35](https://github.com/nubisproject/nubis-kubernetes/pull/35) ([limed](https://github.com/limed))
- Service discovery for kubernetes components [\#34](https://github.com/nubisproject/nubis-kubernetes/pull/34) ([limed](https://github.com/limed))
- Use kubelet for node health-check and expose purpose [\#33](https://github.com/nubisproject/nubis-kubernetes/pull/33) ([gozer](https://github.com/gozer))
- Actually forward kube logs to fluent [\#32](https://github.com/nubisproject/nubis-kubernetes/pull/32) ([limed](https://github.com/limed))
- Initial attempt to get kubernetes logs sent to fluent [\#30](https://github.com/nubisproject/nubis-kubernetes/pull/30) ([limed](https://github.com/limed))
- Added some outputs [\#26](https://github.com/nubisproject/nubis-kubernetes/pull/26) ([limed](https://github.com/limed))
- Seperate out user data, now has bastion, master and node [\#23](https://github.com/nubisproject/nubis-kubernetes/pull/23) ([limed](https://github.com/limed))
- Refine cluster rolling update timing [\#20](https://github.com/nubisproject/nubis-kubernetes/pull/20) ([tinnightcap](https://github.com/tinnightcap))
- Fixing typos [\#19](https://github.com/nubisproject/nubis-kubernetes/pull/19) ([limed](https://github.com/limed))
- Multiple Changes:   - Increase minion count to 2   - Fix SG count error   - Switch networking over to Weave [\#18](https://github.com/nubisproject/nubis-kubernetes/pull/18) ([gozer](https://github.com/gozer))
- Create our own custom security group to allow inbound ssh [\#12](https://github.com/nubisproject/nubis-kubernetes/pull/12) ([gozer](https://github.com/gozer))
- build centos too [\#10](https://github.com/nubisproject/nubis-kubernetes/pull/10) ([gozer](https://github.com/gozer))
- \[nubis-metadata\] Pull clout-init feature from nubis-base [\#9](https://github.com/nubisproject/nubis-kubernetes/pull/9) ([gozer](https://github.com/gozer))
- Some progress [\#8](https://github.com/nubisproject/nubis-kubernetes/pull/8) ([tinnightcap](https://github.com/tinnightcap))
- Cleanup old skel content [\#3](https://github.com/nubisproject/nubis-kubernetes/pull/3) ([gozer](https://github.com/gozer))
- Sharing work in progress [\#2](https://github.com/nubisproject/nubis-kubernetes/pull/2) ([tinnightcap](https://github.com/tinnightcap))
- Adding travis integration [\#1](https://github.com/nubisproject/nubis-kubernetes/pull/1) ([tinnightcap](https://github.com/tinnightcap))


\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*