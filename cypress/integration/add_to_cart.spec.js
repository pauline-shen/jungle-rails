describe("Add to cart", () => {
  it("should visit homepage", () => {
    cy.authenticateUrl("/", "Jungle", "book");
  });
  it("should add to cart and increment item count", () => {
    cy.get("article")
    .first()
    .get(".btn").contains("Add").click({force: true})

    cy.contains(".end-0", "My Cart (1)")
  });
});