module Handler.FeedbackNew where

import Import
import Yesod.Form.Bootstrap3
--import Text.Markdown (Markdown)
import Yesod.Text.Markdown

--data Feedback = Feedback
--  { team :: Text
--  , comments :: Markdown
--  }

feedbackForm :: AForm Handler Feedback
feedbackForm =  Feedback
                <$> areq textField (bfs ("Team":: Text)) Nothing
                <*> areq markdownField (bfs ("Comments":: Text)) Nothing

getFeedbackNewR :: Handler Html
getFeedbackNewR = do
  (widget,enctype) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm feedbackForm
  defaultLayout $(widgetFile "feedback/new")

postFeedbackNewR :: Handler Html
postFeedbackNewR = do
  ((res, widget), enctype) <- runFormPost $ renderBootstrap3 BootstrapBasicForm feedbackForm
  case res of
    FormSuccess feedback -> do
      feedbackId <- runDB $ insert feedback
      redirect $ FeedbackDetailsR feedbackId
    _ -> defaultLayout $(widgetFile "feedback/new")
