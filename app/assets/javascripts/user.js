class User {
  constructor(id, username, image, accountType, teams) {
    this.id = id;
    this.username = username;
    this.image = image;
    this.accountType = accountType;
    this.teams = teams;
  }

  buildHTML() {
    return `
    <img src="${this.image}">
    <h1>${this.username}</h1>
    <h3>Account Type: ${this.accountType}</h3>
    `;
  }

  buildTeamsHTML() {
    let HTML = [];
    for (let i in this.teams) {
      let id = this.teams[i]["id"];
      let avatar = this.teams[i]["avatar_url"];
      let name = this.teams[i]["name"];
      let desc = this.teams[i]["description"];
      let goals = this.teams[i]["goals"];
      let slack = this.teams[i]["communication_method"];
      HTML.push(`<a href="/teams/${id}"><h1>${name}</h1></a><img src="${avatar}"><h3>Description: ${desc}</h3><h3>Goals: ${goals}</h3><h3>Slack: ${slack}</h3>`);
    }
    return HTML;
  }

  updateDOM(html) {
    $('#show-user').append(html);
  }
}

$(document).ready(function () {
  const userID = parseInt(document.URL.split('/')[4]);

  $.get(`/users/${userID}.json`, (data) => {
    const id = data['id'];
    const username = data['username'];
    const avatar = data['avatar_url'];
    const acctType = data['account_type'];
    const teams = data['teams'];

    let user = new User(id, username, avatar, acctType, teams);
    user.updateDOM(user.buildHTML());
    user.updateDOM(user.buildTeamsHTML());
  });
});