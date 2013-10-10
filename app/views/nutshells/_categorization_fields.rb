.nested-fields
  =f.association :categorizations, label: "Context of Thynkdup",
  collection: Category.all(order: "name"), prompt: "Choose a Category"
