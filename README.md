## Inspiration
Our inspiration for Exer came when we noticed 3 things - the 3 things we think to be most critical in today’s modern world. Firstly, our health and well-being is a vital part of our daily lives, so we wanted this to be a central point in our project. Especially with the COVID-19 pandemic, people are spending more time inside, so we wanted to create an app that encouraged a more active lifestyle. In addition, it is more essential than ever to be technologically literate, so we wanted to not only make use of interesting tech, but also teach others about it. Finally, money is an essential part of our modern society, and by combining these three things, we ended up with Exer.

## What it does
Exer is a mobile app in which users get paid to walk. In particular, every step a user takes gets converted into Exercoin, our very own custom cryptocurrency based on the ERC20 blockchain. Users can also see a global leaderboard and compete for the most steps each day. Finally, the app has an education section where you can read articles about blockchain, the technology which powers many cryptocurrencies including Exercoin.

## How we built it
- For user authentication, we incorporated a ‘Sign in with Google’ feature using Firebase. We also use Firestore to hold user information such as Exercoin wallet addresses.
- We built the app frontend with Flutter, which, alongside cross-platform support for iOS and Android, gave us many options to create aesthetically pleasing design elements.
- The backend server was built using the Express.js framework running in Node, and it is responsible for features such as handling transaction requests from the app, as well as connecting to the Exercoin blockchain to make transactions.
- Finally, we used Ganache to create the Exercoin blockchain. It runs on the Ethereum ERC20 standard and stores both the balances of each user wallet, as well as an archive of all past transactions. All of the Exercoin in circulation is initially held in one master wallet. As users take more steps, transactions are made to their personal wallets, and blocks representing these transactions are added to the blockchain for safekeeping. Similarly, when users redeem their Exercoin, it is moved back to the master wallet.

## Challenges we ran into
- The first challenge we ran into was getting the app's pedometer feature to accurately track a user's steps. There were some strange quirks in how the phone's pedometer keeps count of steps, so we had to do some math to keep an accurate step count.
- In addition, creating some of the complex UI elements in the app proved to be quite difficult. We had to use sophisticated libraries and read through lots of documentation to figure them out.
- Finally, connecting our web server to the Exercoin blockchain proved to be a challenge.

## Accomplishments that we're proud of
None of us had any prior experience working with Blockchain, so we're proud that we were able to both learn about it and made a fully functioning, polished app in 36 hours.

## What we learned
- We learned about how blockchain works and how to incorporate it into projects
- How to connect Flutter apps with our server backend through APIs
- How to manage our time efficiently to go from idea to project in a short time span 

## What's next for Exer
- Currently users cannot redeem their Exercoin for anything of monetary value, so we hope to include this in the future. Doing so would require forming partnerships with sponsors who could advertise and offer rewards to our users in exchange for valuing our currency.