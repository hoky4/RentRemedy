# Rent Remedy (iOS/Android - Flutter)

Rent management tool to facilitate communication between landlords and tenants, mange/pay rent, and file maintenance reports. Rent Remedy is different because it has a focus on ease of use, consolidation of information through a messaging and file transfer system, and useful data presentation. Rent Remedy has an especially strong focus on features which will make the chaotic first and last months of a lease seamless and smooth for tenants and landlords.


## Onboard Tenant
![onboarding](https://user-images.githubusercontent.com/96437864/163682288-89685212-9f76-43c6-a7e6-e95a228f7fdf.gif)


## Interactable Payment Reminder Messages
![payment](https://user-images.githubusercontent.com/96437864/163682786-88d79db8-44b9-4d88-b734-aafe05cdaa0b.gif)


## File Maintenance Requests and get status updates
![maintenance request 1](https://user-images.githubusercontent.com/96437864/163683448-77429436-7eb4-4c73-aa0c-4eea6254afef.gif) ![maintenance request 2](https://user-images.githubusercontent.com/96437864/163683873-8c734766-5345-405b-b7c1-ee24845afc56.gif)


## Terminate Lease Agreement
![termination](https://user-images.githubusercontent.com/96437864/163682990-60896396-791d-45e4-be62-2387ad5d8b9f.gif)


## Review Landord
![review landlord](https://user-images.githubusercontent.com/96437864/163684040-f5aaaf06-a9f0-4138-b843-aa151be5647b.gif)


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
