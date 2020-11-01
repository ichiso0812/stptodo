
<template>
    <form @submit.prevent="signin">  
        <div v-if="error">{{ error }}</div>
        Salut c'est le form

        <label>Mail:
        <input type="email" v-model="email" id="email"/>
        </label>

        <label>Pass:
        <input type="password" v-model="password" id="password"/>
        </label>   

        <button type="submit">Sign in</button>

        <router-link to="/signup">Sign up</router-link>
    </form>

</template>

<script lang="coffee">
export default
    name: "Signin",
    data: 
        email: "",
        password: "",
        error: ""
    created: -> this.check_signed_in,
    updated: -> this.check_signed_in,
    methods:
        signin: -> #see routes.rb
            this.$http.plain.post("/signin", {email: this.email, password: this.password})
            .then((response) => this.sign_in_successful(response))
            .catch((error) => this.sign_in_failed(error))
        sign_in_successful: (response) ->
            if not response.data.csrf
                this.sign_in_failed response
                return
            localStorage.csrf = response.data.csrf
            localStorage.signedIn = true
            this.error = ""
            this.$router.replace("/projects")
        sign_in_failed: (error) ->
            this.error = (error.response && error.response.data && error.response.data.error) || ""
            delete localStorage.csrf
            delete localStorage.signedIn
        check_signed_in: () ->
            this.$router.replace("/projects") if localStorage.signedIn
</script>

<style  scoped>

</style>
