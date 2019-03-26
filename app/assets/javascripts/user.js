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
    <div class="user-profile">
      <img src="${this.image}" class="user-profile-image">
      <h1>${this.username} <a href="/users/${this.id}/edit"><i class="fas fa-user-edit"></i></a></h1>
      <h3>Account Type: ${this.accountType}</h3>
    </div>
    <hr>
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
      HTML.push(`
      <div class="user-page team">
        <a href="/teams/${id}"><h1>${name}</h1></a>
        <img src="${avatar}">
        <h3>Description: ${desc}</h3>
        <h3>Goals: ${goals}</h3>
        <h3>Slack: ${slack}</h3>
      </div>`);
    }
    return HTML;
  }

  updateDOM(html) {
    $('#show-user').append(html);
  }
}

function userHover() {
  $('#show-user div.team').hover(function() {
    $(this).addClass('team-mouseover');
    console.log(this);
  }, function() {
    $(this).removeClass('team-mouseover');
  });
}

$(document).ready(function () {
  const userID = parseInt(document.URL.split('/')[4]);

  fetch(`/users/${userID}.json`)
  .then((response) => {
    return response.json();
  })
  .then((data) => {
    const id = data['id'];
    const username = data['username'];
    const avatar = data['avatar_url'];
    const acctType = data['account_type'];
    const teams = data['teams'];
    
    let user = new User(id, username, avatar, acctType, teams);
    user.updateDOM(user.buildHTML() + user.buildTeamsHTML());
    userHover();
  });
  
  // $.get(`/users/${userID}.json`, (data) => {
  //   const id = data['id'];
  //   const username = data['username'];
  //   const avatar = data['avatar_url'];
  //   const acctType = data['account_type'];
  //   const teams = data['teams'];
    
  //   let user = new User(id, username, avatar, acctType, teams);
  //   user.updateDOM(user.buildHTML() + user.buildTeamsHTML());
  //   userHover();
  // });
  
});