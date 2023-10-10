
Entities:

- Streaming site
- Customer
- Customer Payment



1.  Conceptual Data Model





2. Logical Data Model







3. Physical Data Model




o add a physical store component to the simplified streaming site database, you can introduce tables and fields to manage physical store locations where users can rent or purchase physical media (e.g., DVDs, Blu-rays). Here's an extended version of the database schema with the physical store:

Entities and Tables:

User Table:
Fields: UserID (Primary Key), Username, Email, Password (hashed).

Content Table:
Fields: ContentID (Primary Key), Title, Genre, ReleaseDate.

Playlist Table:
Fields: PlaylistID (Primary Key), UserID (Foreign Key), Title.

PlaylistContent Table:
Fields: PlaylistContentID (Primary Key), PlaylistID (Foreign Key), ContentID (Foreign Key).

StreamingHistory Table:
Fields: HistoryID (Primary Key), UserID (Foreign Key), ContentID (Foreign Key), Timestamp.

Store Table:
Fields: StoreID (Primary Key), StoreName, Location, Address, Phone.
Inventory Table:

Fields: InventoryID (Primary Key), StoreID (Foreign Key), ContentID (Foreign Key), StockQuantity, Price, Format (e.g., DVD, Blu-ray).

Transaction Table:
Fields: TransactionID (Primary Key), UserID (Foreign Key), StoreID (Foreign Key), TransactionDate, TotalAmount.

TransactionDetail Table:
Fields: DetailID (Primary Key), TransactionID (Foreign Key), ContentID (Foreign Key), Quantity, UnitPrice.
Relationships:

Users can have multiple playlists.
Playlists can contain multiple pieces of content.
Users can have a streaming history.
Physical stores have an inventory of content available for sale or rent.
Users can make transactions at physical stores, renting or purchasing content.


USER (1) --(1 to many)--> PLAYLIST

Each USER can have multiple PLAYLISTs, but each PLAYLIST belongs to one USER.
USER (1) --(1 to many)--> STREAMINGHISTORY

Each USER can have multiple entries in STREAMINGHISTORY, representing their streaming activities. However, each entry in STREAMINGHISTORY belongs to one USER.
CONTENT (many) --(many to many)--> PLAYLIST

Many pieces of CONTENT can be part of many PLAYLISTs, and each PLAYLIST can contain many pieces of CONTENT. This is a many-to-many relationship, as multiple CONTENT items can be associated with multiple PLAYLISTs.
USER (1) --(1 to many)--> TRANSACTION

Each USER can have multiple TRANSACTIONS, representing their purchases or rentals at physical STOREs. However, each TRANSACTION belongs to one USER.
STORE (1) --(1 to many)--> INVENTORY

Each STORE can have multiple items in its INVENTORY, representing the physical media available for sale or rent. However, each item in INVENTORY belongs to one STORE.
TRANSACTION (1) --(1 to many)--> TRANSACTIONDETAIL

Each TRANSACTION can have multiple TRANSACTIONDETAIL entries, specifying the details of the items purchased or rented during the TRANSACTION. However, each TRANSACTIONDETAIL belongs to one TRANSACTION.