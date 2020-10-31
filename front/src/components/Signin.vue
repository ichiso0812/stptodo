
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

<script>
export default {
    name: "signin",
    data () {
        return {
            email: "",
            password: "",
            error: "",
        }
    },
    created() {
        this.checkSignedIn()
    },
    updated() {
        this.checkSignedIn()
    },
    methods: {
        signin() {
            //see routes.rb
            this.$http.plain.post("/signin", {email: this.email, password: this.password})
                .then(response=> this.signinSuccessful(response))
                .catch(error => this.signinFailed(error))
        },
        signinSuccessful(response) {
            console.log("hellot")
            console.log(response.data[0].csrf)
            if (!response.data[0].csrf) {
                this.signinFailed(response)
                return
            }
            localStorage.csrf = response.data.csrf
            localStorage.signedIn = true
            this.error = ""
            console.log("hello")
            this.$router.replace("/projects")
        },
        signinFailed(error) {

            this.error = (error.response && error.response.data && error.response.data.error) || ""
            delete localStorage.csrf
            delete localStorage.signedIn
        },
        checkSignedIn(){
            if (localStorage.signedIn) {
                this.$router.replace("/projects")
            }
        }
    }
}

</script>

<style scoped>

</style>
