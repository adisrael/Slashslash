// Get the modal
$(document).ready(()=>{
  const closeLogIn = document.getElementById("closeLogIn");
  const closeSignUp = document.getElementById("closeSignUp");
  const logInModal = document.getElementById('logInModal');
  const logInBtn = document.getElementById("logInBtn");
  const signUpModal = document.getElementById('signUpModal');
  const signUpBtn = document.getElementById("signUpBtn");



  // When the user clicks on the button, open the modal
  if (logInBtn && logInModal){
    logInBtn.onclick = function() {
      logInModal.style.display = "block";
    }
    // When the user clicks on <span> (x), close the logInModal
    closeLogIn.onclick = function() {
      logInModal.style.display = "none";
    }

    // When the user clicks anywhere outside of the logInModal, close it
    window.onclick = function(event) {
      if (event.target == logInModal) {
        logInModal.style.display = "none";
      }
    }
  }

  if (signUpBtn && signUpModal){
    signUpBtn.onclick = function() {
      signUpModal.style.display = "block";
    }
    // When the user clicks on <span> (x), close the signUpModal
    closeSignUp.onclick = function() {
      signUpModal.style.display = "none";
    }

    // When the user clicks anywhere outside of the signUpModal, close it
    window.onclick = function(event) {
      if (event.target == signUpModal) {
        signUpModal.style.display = "none";
      }
    }
  }
})
