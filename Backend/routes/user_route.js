const express = require('express')

const router = express.Router()

const User = require('.././models/user_model')

// signup

router.post('/signup',(req,res)=>{
  User.findOne({email:req.body.email},(err,user)=>{
      if(err){
          console.log(err)
          res.json(err)
      }else{
          if(user==null){
              const user = User({
                  email:req.body.email,
                  password:req.body.password
              })
              user.save()
              .then((err)=>{
                  if(err){
                      console.log(err)
                      res.json(err)
                  }else{
                      console.log(user)
                      res.json(user)
                  }
                  
              })
          }else{

          res.json({
              message:'email is already in use'
          })   
          }
      }
  })
  
})

router.post('/signin',(req,res)=>{
  User.findOne({email:req.body.email,password:req.body.password},(err,user)=>{
      if(err){
          console.log(err)
          res.json(err)
      }else{
          res.json(user)   
      }
  })
})
module.exports = router
