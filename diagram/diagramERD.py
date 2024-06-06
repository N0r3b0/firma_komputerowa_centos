from graphviz import Digraph
from PIL import Image

# Tworzenie diagramu ERD
dot = Digraph()

# Tabele
dot.node('Products', 'Products\n(Product_ID, Name, Specification, Price, Availability, Category)')
dot.node('Customers', 'Customers\n(Customer_ID, First_Name, Last_Name, Email, Phone, Address)')
dot.node('Orders', 'Orders\n(Order_ID, Customer_ID, Order_Date, Status)')
dot.node('Order_Details', 'Order_Details\n(Order_Detail_ID, Order_ID, Product_ID, Quantity, Price)')
dot.node('Suppliers', 'Suppliers\n(Supplier_ID, Name, Contact)')
dot.node('Shipments', 'Shipments\n(Shipment_ID, Supplier_ID, Shipment_Date, Status)')
dot.node('Employees', 'Employees\n(Employee_ID, First_Name, Last_Name, Position)')
dot.node('Payments', 'Payments\n(Payment_ID, Order_ID, Payment_Date, Amount)')

# Relacje
dot.edge('Orders', 'Customers', label='Customer_ID')
dot.edge('Order_Details', 'Orders', label='Order_ID')
dot.edge('Order_Details', 'Products', label='Product_ID')
dot.edge('Shipments', 'Suppliers', label='Supplier_ID')
dot.edge('Payments', 'Orders', label='Order_ID')

# Wyświetlenie diagramu
dot.attr(dpi='300')
diagram_path = dot.render('ERD_diagram', format='png', cleanup=False)

# Otwórz i wyświetl obrazek
img = Image.open(diagram_path)
img.show()
