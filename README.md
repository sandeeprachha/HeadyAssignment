# HeadyAssignment
Requirment
This assessment is for us to test your basic skill set, this includes your technical Swift skills as
well as ​your ​logical ​& ​organisational ​skills.
For following JSON (URL: https://stark-spire-93433.herokuapp.com/json), your task is to create a
mobile ​iOS ​interface ​that ​would ​consume ​and ​output ​the ​data.
Assuming the data is being delivered asynchronously from the URL shared above, persist the
data ​into ​a ​local ​datastore.
Based on the data, design a navigation for the app. The data contains basic e-commerce logic,
there are categories/sub-categories for different products. Products have properties like size,
colour ​and rankings.
In the “ranking” section, products are grouped into ranking. Design an approach to sort or
group ​the ​products ​based ​on ​the ​ranking ​it ​falls ​under.
You will have to display this data in best possible way you can imagine. User should be able to
browse ​data ​category/sub-category ​wise.

# Considerations
I have Integrated Realm as a local storage, to save data from the API.
# Category
While Implementing Catgeories, found nested subcategories in josn response..
Eg:category Men's Wear has sub categories Bottom Wear, Foot wear, Upper wear agin these sub-categories have their sub categories.
We have 3 level categories 
Considering this, I'm shoiwng Category 1 in the list, which inturn opens Category 2 list.
When User clicks Category 2, navigating to show category 3 which are belongs to category 2.
Each category 3 will have many products and each product have different variants based on color, size, price.
I have implemented scrollable menu with category 3, wheh user clicks on catgoey 3, it will show respective Products and variants.As we don't have any images for products and variant, showing variannt based on color it have.

# Ranking

We have 3 kinds of Ranks, Each Rank have Products from different categories.
fetching Products which stored in local storage and showing based on Ranking.

