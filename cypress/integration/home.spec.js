describe("Navigation", () => {
  it("should visit homepage", () => {
    cy.authenticateUrl("/", "Jungle", "book");
  });
  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });
  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length",2);
  });
});