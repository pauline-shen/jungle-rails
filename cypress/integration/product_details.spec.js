describe("Product detailis", () => {
  it("should visit homepage", () => {
    cy.authenticateUrl("/", "Jungle", "book");
  });
  it("should go to product page", () => {
    cy.get("article")
    .first()
    .click()

    cy.contains(".product-detail", "Scented Blade")
  });
});