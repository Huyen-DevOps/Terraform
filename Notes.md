# Notes

## Ensure `user_data` Executes on Instance Startup

You need to make sure that `user_data` is executed when the instance starts.  
You can check the logs to see if `user_data` ran successfully.

**Recommendation:** Check cloud-init Logs on the EC2 Instance

SSH into your EC2 instance and check the `cloud-init` log for any errors:

```bash
cat /var/log/cloud-init-output.log
```

This log will show you if there were any issues during the execution of `user_data`.

---

## If you see: `WARNING: apt does not have a stable CLI interface. Use with caution in scripts.`

This warning appears when you use `apt` in automation scripts, such as in the `user_data` section of an EC2 instance.  
**Recommendation:** Use `apt-get` instead of `apt` in your scripts.

---

## How to Check Network Connectivity Between Two Instances

**Recommendation:** To test if two instances can communicate, use:

```bash
ping <IP> # or hostname
```

**Recommendation:** If ICMP (ping) is blocked by security groups, use:

```bash
telnet <IP> <port>
# or
nc -zv <IP> <port>
```

Make sure the security groups and network ACLs allow the required traffic.

---

## Nếu bạn muốn ssh vào một Private instance thông qua NAT instance

**Recommendation:** EC2 trong private subnet phải cho phép kết nối SSH (port 22) từ NAT instance
                    Bạn cần có key pair phù hợp để SSH vào các instances, tức là Private instance mà bạn muốn SSH vào phải có key pair.

---

## Luồng truy cập Internet từ EC2 private

- EC2 A (10.0.2.10) gửi request đến google.com.
- Routing table của subnet private trỏ về NAT instance như default gateway.
- Gói tin đến NAT instance qua interface eth1 (private IP).
- iptables (POSTROUTING MASQUERADE) thay đổi IP nguồn thành public IP của NAT.
- NAT instance gửi gói ra Internet qua eth0.
- Google trả lời về địa chỉ public IP của NAT.
- NAT instance nhận gói trả lời, dịch ngược (DNAT) và chuyển trả lại EC2 A.

---

## Để Terraform destroy rồi create lại resource
- **Recommendation:** Sử dụng `-target` để chỉ định resource cụ thể mà bạn muốn destroy và sau đó apply lại.
```bash`
- terraform destroy -target <resource_type>.<resource_name> -target <resource_type2>.<resource_name2>
- terraform apply
```
