
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