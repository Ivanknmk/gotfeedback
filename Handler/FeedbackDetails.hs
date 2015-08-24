module Handler.FeedbackDetails where

import Import

getFeedbackDetailsR :: FeedbackId -> Handler Html
getFeedbackDetailsR feedbackId = do
  feedback <- runDB $ get404 feedbackId
  defaultLayout $(widgetFile "feedbackDetails/feedback")
