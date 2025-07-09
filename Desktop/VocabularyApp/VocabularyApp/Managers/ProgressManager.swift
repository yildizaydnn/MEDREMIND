//
//  ProgressManager.swift
//  VocabularyApp
//
//  Created by Yıldız Aydın on 9.07.2025.
//

import Foundation
import Combine

//kullanıcının ilerlemesini yöneten sınıf.

class ProgressManager: ObservableObject {
   
    @Published var userProgress: UserProgress {
        didSet {
            saveProgress()
        }
    }
    
    private let userProgressKey = "userProgress" //userDefaults için anahtar
    private let allLevels: [Level] //tüm seviyelere erişim
    
    init( allLevels: [Level]) {
        self.allLevels = allLevels
        _userProgress = Published(initialValue: loadProgress())
    }
    
    func completeDay() {
        userProgress.completedDays += 1
        print("Tebrikler 🎉 Gün Tamamlandı! Toplam tamamlanan gün: \(userProgress.completedDays)")
        
        let daysPerLevel = 1 //bir seviye atlamak için tamamlanması gereken gün sayısı
        if userProgress.completedDays % daysPerLevel == 0 {
            let nextLevelNumber = userProgress.currentLevel + 1
            //bir sonraki seviye mevcutsa ilerler
            
            if allLevels.contains(where: { $0.levelNumber == nextLevelNumber }) {
                print("Seviye atlandı! Yeni seviye: \(userProgress.currentLevel)")
            } else {
                print("Tebrikler! Tüm seviyeler tamamlandı.")
            }
        }
    }
    
    func addWordToSaveWords(_ word: Word) {
        if !userProgress.saveWords.contains(where: { $0.id == word.id }) {
            userProgress.saveWords.append(word)
            print("Kelime  '\(word.english)' kaydedildi")
        } else {
            print("Kelime '\(word.english)' zaten kaydedilmiş")
        }
    }
    
    func removeWordFromSaveWords(_ word: Word) {
        userProgress.saveWords.removeAll { $0.id == word.id }
        print("Kelime kaydedilen kelimelerden silindi")
    }
    
    //ilerlemeyi userDefaultsa kaydediyoruz
    
    private func saveProgress() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(userProgress)
            UserDefaults.standard.set(data, forKey: userProgressKey)
            print("Kulanıcı ilerlemesi kaydedildi")
            
        } catch {
            print("Hata: \(error.localizedDescription)")
        }
    }
    
    //kullanıcı ilerlemesini userDefaulstan yüklüyoruz
    
    private func loadProgress() -> UserProgress {
        if let savedData = UserDefaults.standard.data(forKey: userProgressKey) {
            do{
                let decoder = JSONDecoder()
                let loadedProgress = try decoder.decode(UserProgress.self, from: savedData)
                print("Kullanıcı ilerlemesi yüklendi. Mevcut seviye:\(loadedProgress.currentLevel), Tamamlanan gün: \(loadedProgress.completedDays)")
                return loadedProgress
                
            } catch {
                print("Kullanıcı ilerlemesi yüklenemedi: \(error.localizedDescription)")
                return UserProgress()
            }
          
        }
        print("Kayıtlı ilerleme bulunamadı. Varsayılan ile başlanıyor")
        return UserProgress()
     
    }
    func resetProgress() {
         UserDefaults.standard.removeObject(forKey: userProgressKey)
         userProgress = UserProgress()
         print("Kullanıcı ilerlemesi sıfırlandı.")
     }
 }



