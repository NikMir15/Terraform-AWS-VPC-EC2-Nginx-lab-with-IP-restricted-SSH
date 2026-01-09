# Notes

## How SSH access is secured
- Port 22 is allowed only from my public IP (/32).
- This prevents open SSH access from the internet.

## Web access
- Port 80 (HTTP) is allowed from anywhere so the Nginx page is reachable in browser.

## Nginx verification
Inside EC2:
- `sudo systemctl status nginx`
From browser:
- `http://<EC2_PUBLIC_IP>` shows "Welcome to nginx!"

## Cleanup
Run from local machine:
- `terraform destroy`
