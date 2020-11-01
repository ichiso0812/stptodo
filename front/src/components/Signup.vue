<template>
    <form @submit.prevent="signup">  
        <div v-if="error">{{ error }}</div>
        Salut c'est le form

        <label>Mail:
        <input type="email" v-model="email" id="email"/>
        </label>

        <label>Pass:
        <input type="password" v-model="password" id="password"/>
        </label>   

        <label>Pass confirmation:
        <input type="password" v-model="password_confirm" id="password_confirm"/>
        </label>   

        <button type="submit">Sign Up</button>

        <router-link to="/">Sign in</router-link>
    </form>
</template>

<script lang="coffee">
export default
    name: "Signup",
    data: 
        email: "",
        password: "",
        password_confirm: "",
        error: ""
    created: -> this.check_signed_in,
    updated: -> this.check_signed_in,
    methods:
        signup: -> 
            #see routes.rb
            this.$http.plain.post("/signup", {email: this.email, password: this.password, password_confirmation: this.password_confirm})
            .then((response) => this.sign_in_successful(response))
            .catch((error) => this.sign_up_failed(error))
        sign_in_successful: (response) ->
            if not response.data.csrf
                this.sign_up_failed response
                return
            localStorage.csrf = response.data.csrf
            localStorage.signedIn = true
            this.error = ""
            this.$router.replace("/projects")
        sign_up_failed: (error) ->
            this.error = (error.response && error.response.data && error.response.data.error) || ""
            delete localStorage.csrf
            delete localStorage.signedIn
        check_signed_in: () ->
            this.$router.replace("/projects") if localStorage.signedIn
</script>

<style scoped>

</style>
