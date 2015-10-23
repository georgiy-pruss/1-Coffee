doc = new DOMParser().parseFromString '
    <inventory title="OmniCorp Store #45x10^3">
      <section name="health">
        <item upc="123456789" stock="12">
          <name>Invisibility Cream</name>
          <price>14.50</price>
          <description>Makes you invisible</description>
        </item>
        <item upc="445322344" stock="18">
          <name>Levitation Salve</name>
          <price>23.99</price>
          <description>Levitate yourself for up to 3 hours per application</description>
        </item>
      </section>
      <section name="food">
        <item upc="485672034" stock="653">
          <name>Blork and Freen Instameal</name>
          <price>4.95</price>
          <description>A tasty meal in a tablet; just add water</description>
        </item>
        <item upc="132957764" stock="44">
          <name>Grob winglets</name>
          <price>3.56</price>
          <description>Tender winglets of Grob. Just add water</description>
        </item>
      </section>
    </inventory>
', 'text/xml'


# "doc" is the XML as a Document object.


# Retrieve the first "item" element
doc.evaluate('//item', doc, {}, 7, {}).snapshotItem 0

# Perform an action on each "price" element (print it out)
prices = doc.evaluate "//price", doc, {}, 7, {}
for i in [0...prices.snapshotLength] by 1
    console.log prices.snapshotItem(i).textContent

# Get an array of all the "name" elements
names = doc.evaluate "//name", doc, {}, 7, {}
names = for i in [0...names.snapshotLength] by 1
    names.snapshotItem i
