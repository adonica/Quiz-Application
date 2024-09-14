#### Device-Agnostic Design Course Project I - 3b8961b4-a970-437d-80ec-47c5b1305d9f

---

# Quiz Application

### Preview

This is a quiz application with various topics to choose from. Once you select a topic, a random question is displayed. You can choose an answer from the provided options.

- If the answer is incorrect, it will be removed from the available options. You can quess as many times as you like, as long as there are options left.

- If the answer is correct, you can move to another question from the same topic.

- The **statistics** button shows how many questions you've answered correctly.
  You can also return to the topic selection with the **Back to the topics**- button and choose a different topic.

---

### Key challenges faced during the project:

- When inserting code in the middle of existing code, it was difficult to know, where to put the missing braces or commas.

- Splitting the code into separate folders was challenging, so I only partially organized the files.

- There was a problem where using hot reload updated the correct answers in the statistics page, even if the questions were not answered or were answered incorrectly. Switching to hot restart solved this issue.

### Key learning moments from working on the project:

- My understanding of how Flutter works has gradually improved.

- I now have a better grasp of using **Navigator** and **MaterialPageRoute**.

- I learned how to use **SharedPreferences** to store and access data across different parts of the app.

---

### List of dependencies in this project:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.2
  shared_preferences: 2.3.2
```
