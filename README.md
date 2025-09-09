# 021 Trade Assignment
My Approach and Explaination
## Phase 1 - Design and AppBar:
- After receiving the assignment mail, I quickly started by brainstorming ideas and making a mockup design on Figma 
- Starting with the AppBar/Header, I decided to put other navigation (like, Marketwatch, Exchanges File, Funds, and User Profile) in a Drawer to avoid Clutteredness
- Then the Live Stock prices listed on AppBar, First I created a json file with thier name and prices, then I created a singleChildScrollView and called the json file via ListView.Builder

## Phase 2 - Filter Options:
- First I decided to place the filter directly but then it would take much place then require, then I put them in a ExpansionTile, My plan was to display the selected filters, even if the ExpansionFile was closed, But it had only one widget 'title'
- I created json file for both Client details, and stock data, then created a TypeAheadField, for drop down options and ease of selection, and passed the json file after comparing the input words with the json data.

##Phase 3 - Table:
- Here I faced problems, First i thought of DataTable widget but it did not had an options for multiple pages, then I got syncfusion_flutter_datagrid, but it was too confusing, Lastly I put PaginatedDataTable. I creatd json file for dummy data.
- I couldn't create Table by myself, I had to take help for it.

![HomePage](https://github.com/user-attachments/assets/3421adce-d584-4f08-8a1e-c1dd21f9de01)
![Drawer](https://github.com/user-attachments/assets/48cf0677-0cfd-45bd-b0c6-19a8d033e16b)
![Filter added](https://github.com/user-attachments/assets/16ce7107-6c64-4c40-93dc-8d2bb0775c22)
![Filter dropdown](https://github.com/user-attachments/assets/ff36cbe1-f727-4265-9560-0a6ff122b8da)

Figma : https://www.figma.com/design/ZErNE8OwAnw9axMYJpj31A/021-Trade-Assignment?t=8K2wy4zAMUi87zhC-1
