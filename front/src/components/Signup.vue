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

<script>
export default {
    name: "signup",
    data () {
        return {
            email: "",
            password: "",
            password_confirm: "",
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
        signup() {
            //see routes.rb
            this.$http.plain.post('/signup', {email: this.email, password: this.password, password_confirmation: this.password_confirm})
                .then(response => {this.signinSuccessful(response)})
                .catch(error => this.signupFailed(error))
        },
        signinSuccessful(response) {
            if (!response.data.csrf) {
                this.signupFailed(response)
                return
            }
            localStorage.csrf = response.data.csrf
            localStorage.signedIn = true
            this.error = ""
            this.$router.replace("/projects")
        },
        signupFailed(error) {
            this.error = (error.response && error.response.data && error.response.data.error) || "FILS DE PUTE"
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
