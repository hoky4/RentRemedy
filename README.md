# Rent Remedy

Rent management tool to facilitate communication between landlords and tenants, mange/pay rent, and file maintenance reports. 

## Onboard Tenant
![onboarding](https://user-images.githubusercontent.com/96437864/163682288-89685212-9f76-43c6-a7e6-e95a228f7fdf.gif)


## How to run project
Set up Flutter https://flutter.dev/docs/get-started/install

1. Download flutter SDK
2. Update path
3. Run "flutter doctor" in terminal
4. Download IDE
   4a. Download flutter plugin in IDE
   4b. Configure dart and flutter path in IDE
   4c. Set up android emulator in IDE

Create a file called ".env.development" at the base directory for the project with the following variables:

API_URL=http://'your ip4 address':5000
WEBSOCKET=ws://'your ip4 address':5000

Create a file called ".env.production" at the base directory for the project with the following variables:

API_URL=https://api.myrentremedy.com
WEBSOCKET=wss://api.myrentremedy.com
